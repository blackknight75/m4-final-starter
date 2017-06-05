function submitLink(){
  var title     = $('#link-title').val()
  var url       = $('#link-url').val()
  var user_id   = $('#user-id').val()
  var read      = $('#link-read').val()
  var linkData  = {user_id: user_id, title: title, url: url, read: read}
  $.ajax({
    method: "POST",
    url: "/api/v1/links",
    data: linkData,
    success: function(link) {
      $("#links-list").prepend(link)
        alert(`You have successfully added ${title} to your links`)
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

$(document).ready(function(){
  $('#create-link-button').click(function() {
      submitLink()
    });
});
