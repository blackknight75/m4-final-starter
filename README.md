# URL Lockbox

> This is an awesome app for keeping tack of all the links that you like. You can keep track of which ones you have and have not read. There is also a companion app that you can use in conjunction with this app to see the top 10 hottest links by view. When you mark a url as read it will add to the view count on the Hot Reads app.

#### Production Links

[Production App](https://thawing-wildwood-17227.herokuapp.com/)

[Hot Reads(Companion App)](https://boiling-woodland-88175.herokuapp.com/)

## Setting up the App

#### Clone the repo

``` $ git clone https://github.com/blackknight75/m4-final-starter ```

#### Run

``` $ bundle intall ```

``` $ rake db:create db:migrate ```

#### If running locally

Make sure that you change the URLs in the links.js to your localhost:port#

###### links.js
``` function markAsUnread(data){
  $.ajax({
    method: "PATCH",
    url: "http://localhost:3000/api/v1/links/" + data.attributes.link_id.value,
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
```
After you have setup your URLs you can launch your rails server locally to view the app and continue to develop.

#### Launch Server

``` $ rails s ```

#### Launch Console

``` $ rails c ```

## Running Tests

#### Run

``` $ rspec ```

## Deploy to Heroku

* Make sure to switch your URLs in the links.js to your Heroku url.

###### links.js
``` function markAsUnread(data){
  $.ajax({
    method: "PATCH",
    url: "https://herokup-app-name.herokuapp.com/api/v1/links/" + data.attributes.link_id.value,
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
```

* Make sure you precompile your JavaScript before you push to your repository and to Heroku

#### Remover Old Minified Files First

``` $ rake assets:clobber ```

#### Precopile JavaScript for Production

``` $ rake assets:precopile ```

#### Push to Your Repo

``` $ git add . ```

``` $ git commit -m "Your commit message" ```

``` $ git push origin branch-name ```

#### Push to Heroku from Your Repo Master

``` $ git push heroku master ```

#### Push to Heroku from a Branch on Your Repo

``` $ git push heroku branch-name:master ```
