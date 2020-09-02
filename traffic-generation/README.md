Need a traffic generator
grabbing mitmproxy so I can learn about the app
Need to figure out all the GETs and POSTs and maybe DELETEs

GET /
GET /owners/find
GET /owners/new
GET /owners?lastName=
GET /owners/<id>
GET /owners/<id>/edit
GET /owners/<id>/pets/new
GET /vets.html
GET /oups

Skip this one - no easy way for me to extract the existing data so I can change just a piece of it
POST /owners/<id>/edit w/ URLEncoded form
firstName: George
lastName:  Franklin
address:   110 W. Liberty St.
city:      Madison
telephone: 6085551023

POST /owners/<id>/pets/new
id:        
name:      Interlake
birthDate: 1900-08-10
type:      bird



POST /owners/new w/ URLEncoded form
firstName: James
lastName:  Musselwhite
address:   10304 Interlake Ave N
city:      Seattle
telephone: 5551234567


