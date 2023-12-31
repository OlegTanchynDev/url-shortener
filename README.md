# README

- Service URL Shortener

- Ruby version 3.3.0

- Rails version 7.1.2

- Admin Panel - https://454c-185-143-144-159.ngrok-free.app/admin/short_links

- REST API Endpoints documented in Swagger - https://454c-185-143-144-159.ngrok-free.app/api-docs/index.html

Project pass this requirements:
Implement a simple service to minimize urls.
The service is a REST API in which you can create a shortened link, and in the future see the number of visits to this link.

- All short urls must be unique and not duplicated.
- When a user clicks on a shortened link, they should be redirected to the full link.
- Implement a simple admin panel that will display a list of all generated short urls and the number of visits to it.
- The administrator should be able to delete shortened link.
- For authorization in the admin panel, you do not need to screw devise for authorization, authorization should be done through basic_auth.
- The REST API must be public, it must have the following methods: (Creation, View all urls with statistics, Removal).
- Access to delete a link (by the user via the REST API) must be done using the password generated during the creation of this link.
- Implement pagination in the admin panel.
- Implement deletion of short urls that have not been visited for more than 2 months (this can be a button in the admin panel).
- Implement a search in the admin panel.