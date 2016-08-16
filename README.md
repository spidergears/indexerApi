# README #

### API to index webpages ###

* This is a sample rails app to index web pages

### How to use the API? ###
* The API currently supports two end points
* One endpoint should receive the URL of the page, grab its content and store its content from tags h1, h2 and h3 and the links to backend database (POST /api/v1/indexed_urls)
```
POST /api/v1/indexed_urls HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cache-Control: no-cache
Postman-Token: 7c1ad209-49c6-3aed-d7d0-6fa7e3bba0ae

{"url": "http://blog.arkency.com/2014/10/how-to-start-using-arrays-in-rails-with-postgresql/"}
```
* Second endpoint to list the urls and content stored in the database (GET /api/v1/indexed_urls)
```
GET /api/v1/indexed_urls HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cache-Control: no-cache
Postman-Token: bba0721b-4583-af0f-8d10-341d5474b6d9
```
* I have used Postman chrome extension to simulate and test API requets, though any rest client that can send json requests should work.
* The code is deployed on AWS and the server can respond to the API requests with the formats as described above
* Server IP: 52.66.121.215

### How do i set this up locally? ###
* Simply clone the repo in your local machine
* Install rvm, ruby & rails and postgres 9+
* Do a `bundle install` in the console/terminal
* Do a `rake db:create` and `rake db:migrate`

### How do i run tests? ###
* Type `rake test` on console
* I mostly use rspec in my projects but have tried my best to take a stab at minitest

### About me ###
* [Github](https://github.com/spidergears)
* [LinkedIn](https://www.linkedin.com/in/spidergears)
* [Twitter](https://twitter.com/spider_gears)
