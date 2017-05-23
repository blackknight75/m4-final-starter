function submitLink(){
  var title = $('#link_title').val()
  var url   = $('#link_url').val()
debugger;
  $.ajax({
    method: "POST",
    url: "/links",
    data: linkData,
    success: function(data) {
        //append new restaurant
        populateNewLink(linkData)
    },
    error: function(data) {
        //error message
    },
  })
}

function populateNewlink(linkData){
  debugger;
  var linkHtml = `<h3>${linktData.title}</h3>`

  $('#links-list').append(linkHtml);

}

$(document).ready(function(){
  $('#create-link-button').click(function() {
      submitLink()
    });
});
