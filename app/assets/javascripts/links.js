function submitLink(){
  var title     = $('#link-title').val()
  var url       = $('#link-url').val()
  var user_id   = $('#user-id').val()
  var read      = $('#link-read').val()
  var linkData  = {user_id: user_id, title: title, url: url, read: read}
  $.ajax({
    method: "POST",
    url: "https://thawing-wildwood-17227.herokuapp.com/api/v1/links",
    // url: "/api/v1/links",
    data: linkData,
    success: function(link) {
      $("#links-list").prepend(link)
      alert(`You have successfully added ${title} to your links`)
      $(`#button${$(link)[0].id}`).click(function() {
        markAsRead(this)
      });
    },
    error: function(link) {
      if($("#link-title").val() == ""){
        alert("Sorry, that is not a valid TITLE. Please try again.");
      } else {
        alert("Sorry, that is not a valid URL. Please try again.");
      }
    },
  })
}

function markAsRead(data){
  $.ajax({
    method: "PATCH",
    url: "https://thawing-wildwood-17227.herokuapp.com/api/v1/links/" + data.attributes.link_id.value,
    // url: "/api/v1/links/" + data.attributes.link_id.value,
    data: {read: true},
    success: function(link) {
      var linkElement = $(`#${link.id}`)[0]
      linkElement.childNodes[5].textContent = "Read: true"
      $(`#${link.id}`)[0].childNodes[11].value = "Mark as Unread"
      $(`#${link.id}`)[0].childNodes[11].classList.value = "mark-as-unread"
      $(`#${link.id}`).css("background", "grey");
      $(`#button${link.id}`).off()
      $(`#button${link.id}`).click(function() {
        markAsUnread(this)
      });
      sendToHotReads(link)
    },
    error: function(link) {
      // alert error
    },
  })
}

function sendToHotReads(link){
  var linkUrl = link.url
  $.ajax({
    method: "POST",
    url: "https://boiling-woodland-88175.herokuapp.com/links",
    // url: "http://localhost:2000/links",
    data: {url: linkUrl}
  })
}

function markAsUnread(data){
  $.ajax({
    method: "PATCH",
    url: "https://thawing-wildwood-17227.herokuapp.com/api/v1/links/" + data.attributes.link_id.value,
    // url: "/api/v1/links/" + data.attributes.link_id.value,
    data: {read: false},
    success: function(link) {
      var linkElement = $(`#${link.id}`)[0]
      linkElement.childNodes[5].textContent = "Read: false"
      $(`#${link.id}`)[0].childNodes[11].value = "Mark as Read"
      $(`#${link.id}`)[0].childNodes[11].classList.value = "mark-as-read"
      $(`#${link.id}`).css("background", "white");
      $(`#button${link.id}`).off()
      $(`#button${link.id}`).click(function() {
        markAsRead(this)
      });
    },
    error: function(link) {
      // alert error
    },
  })
}

function showAll(){
  $(`.link-data`).show()
}

function filterRead() {
  $('.link-data').hide()
  $(`.mark-as-read`).parent().show()
}

function filterUnread() {
  $('.link-data').hide()
  $(`.mark-as-unread`).parent().show()
}

function searchFilter(){
  $('#filter-name input').on("keyup", function(){
    $('.link-data').show()
    var searchInput = ($(this).val()).toLowerCase()
    var links = $('.link-data')
    links.each(function(){
      var linkTitle = ($(this).children()[0].innerText).toLowerCase()
      var matches = linkTitle.includes(searchInput)
      if(!matches) {
        $(this).hide();
      }
    })
  })
}

$(document).ready(function(){
  $('#create-link-button').click(function() {
      submitLink()
    });
  $('.mark-as-read').click(function() {
    markAsRead(this)
  });
  $('.mark-as-unread').click(function() {
    markAsUnread(this)
  });
  $('#show-unread').click(function() {
    filterRead()
  });
  $('#show-read').click(function() {
    filterUnread()
  });
  $('#show-all').click(function() {
    showAll()
  });
  searchFilter()
});
