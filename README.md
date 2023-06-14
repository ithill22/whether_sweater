<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<br />
<div align="center">
  <h3 align="center">Whether, Sweater?</h3>

  <p align="center">
  Turing School of Software & Design - Mod 3 - Final Project
  <br />
  <a href="https://backend.turing.edu/module3/projects/sweater_weather/"><strong>Turing docs</strong></a>
  </p>
</div>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
    <a href="#project-description">About The Project</a>
    <ul>
      <li><a href="#learning-goals">Learning Goals</a></li>
      <li><a href="#versions">Versions</a></li>
      <li><a href="#important-gems">Important Gems</a></li>
      <li><a href="#database-schema">Database Schema</a></li>
    </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#repo-set-up">Repo Set Up</a></li>
        <li><a href="#use-of-repo">Use of Repo</a></li>
          <ul>
            <li>Backend Server</li>
          </ul>
      </ul>
    </li>
    <li>
      <a href="#api">Whether, Sweater?</a>
      <details>
        <summary>Available Endpoints</summary>
        <ul>
          <li><a href="#forecast-endpoint">Forecast Endpoint</a></a></li>
          <li><a href="#user-endpoint">User Endpoint</a></a></li>
          <li><a href="#session-endpoint">Session Endpoint</a></a></li>
          <li><a href="#roadtrip-endpoint">Road Trip Endpoint</a></a></li>
          <li><a href="#booksearch-endpoint">Book Search Endpoint</a></a></li>
          <li><a href="#background-endpoint">Background Endpoint</a></a></li>
        </ul>
      </details>
    </li>
  </ol>
</details>

----------

## Project Description

This repository contains the back-end code for a road trip planning application. The application follows a service-oriented architecture, with the front-end communicating with the back-end through an API. The main functionality of the API is to provide users with current weather information and forecasted weather for their destination. 

## Learning Goals:

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)
- README creation practice

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### Versions

- 'Ruby 3.1.1'
- 'Rails 7.0.5'

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### Important Gems

- Testing:
![Pry][Pry-img]
![RSPEC][RSPEC-img]
![Shoulda Matchers][Shoulda Matchers-img]
![Simplecov][Simplecov-img]
![VCR][VCR-img]

- API: [jsonapi-serializer](https://github.com/fotinakis/jsonapi-serializers), [figaro](https://github.com/laserlemon/figaro), [faraday](https://github.com/lostisland/faraday)

- User Authentication and Security: [bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

## Database Schema
```
 create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_users_on_api_key", unique: true
  end
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

## Getting Started

### Repo Set Up
On your local system, open a terminal session and run the following:
1. Clone this repo `$ git clone git@github.com:ithill22/whether_sweater.git`
2. Navigate into your new repo `$ cd whether_sweater`
3. Run `$ bundle install` to install the requiored gems
4. Set up the database locally with `$ rails db:{drop,create,migrate}`
5. Open your text editor to make sure the new `schema.rb` exists
8. Run the RSpec test suite locally with the command `$ bundle exec rspec` to ensure everything is functioning correctly

### External API Set Up
1. Sign up for API keys from the following sources:
- [MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
- [MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api/)
- [Weather API](https://www.weatherapi.com/docs/)
- [Unsplash Image Search API](https://unsplash.com/documentation#search-photos)
- [Open Library Book Search API](https://openlibrary.org/dev/docs/api/search)
2. Set up the `figaro` gem: `$ bundle exec figaro install`
3. Navigate to `/config/application.yml`
4. Add your API credentials to the file following this format and ensure it was properly add to `.gitignore`:
  ```
  MAP_API_KEY: 'YOUR_API_KEY'
  WEATHER_API_KEY: 'YOUR_API_KEY'
  IMAGE_API_KEY: 'YOUR_API_KEY'
  ```

### Use of this Repository

**Backend Server**

On you command line:
1. Navigate to the local directory where the backend repo is hoursed
2. Run `$ rails server` to the run the server locally
3. Open a web browser and navigate to http://localhost:3000/
4. Here you able able to explore the endpoints exposed by the API

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

## API
Available endpoints

### Forecast endpoint

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /forecast | location | Returns current, daily, and hourly weather data for the given location | /api/v1/forecast?location=denver,co |

Data sourced from [MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) and [Weather API](https://www.weatherapi.com/docs/)

<details>
  <summary> JSON response examples </summary>


Forecast by location:
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current": {
                "last_updated": "2023-06-13 17:45",
                "temperature": 60.1,
                "feels_like": 60.1,
                "humidity": 62,
                "uvi": 4.0,
                "visibility": 9,
                "conditions": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
            },
            "daily": [
                {
                    "date": "2023-06-13",
                    "sunrise": "05:32 AM",
                    "sunset": "08:29 PM",
                    "max_temp": 63.9,
                    "min_temp": 51.6,
                    "conditions": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
                },
                {
                    "date": "2023-06-14",
                    "sunrise": "05:32 AM",
                    "sunset": "08:29 PM",
                    "max_temp": 82.9,
                    "min_temp": 52.3,
                    "conditions": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
                },
                {
                    "date": "2023-06-15",
                    "sunrise": "05:32 AM",
                    "sunset": "08:29 PM",
                    "max_temp": 74.3,
                    "min_temp": 56.1,
                    "conditions": "Moderate rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png"
                },
                {
                    "date": "2023-06-16",
                    "sunrise": "05:32 AM",
                    "sunset": "08:30 PM",
                    "max_temp": 73.0,
                    "min_temp": 53.8,
                    "conditions": "Moderate rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png"
                },
                {
                    "date": "2023-06-17",
                    "sunrise": "05:32 AM",
                    "sunset": "08:30 PM",
                    "max_temp": 80.8,
                    "min_temp": 53.1,
                    "conditions": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
                }
            ],
            "hourly": [
                {
                    "time": "2023-06-13 00:00",
                    "temperature": 54.1,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-06-13 01:00",
                    "temperature": 53.6,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-06-13 02:00",
                    "temperature": 53.2,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-06-13 03:00",
                    "temperature": 52.3,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                {
                    "time": "2023-06-13 04:00",
                    "temperature": 52.0,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                }
            ]
        }
    }
}
```

</details>

### User endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| POST | /users | Registers a new user in the backend database | /api/v1/users |

<details>
  <summary> JSON request/response examples </summary>

Register User Request:
  ```
  {
    "email": "test_email@test.com",
    "password": "password",
    "password_confirmation": "password"
  }
  ```
Created User:
  ```
  {
    "data":{
      "id": "1",
      "type": "users",
      "attributes": {
        "email": "test_email@test.com",
        "api_key": "<user_api_key>"
      }
    }
  }
  ```

</details>

### Session endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| POST | /sessions | Log In an existing user in the backend database | /api/v1/sessions |

<details>
  <summary> JSON request/response examples </summary>

LogIn User Request:
  ```
  {
    "email": "test_email@test.com",
    "password": "password"
  }
  ```
Authenticated Session User:
  ```
  {
    "data": {
      "id": "1",
      "type": "users",
      "attributes": {
        "email": "test_email@test.com",
        "api_key": "<user_api_key>"
      }
    }
  }
  ```

</details>

### Road Trip endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| POST | /road_trip | Returns road trip data for specified origin and destination | /api/v1/road_trip |

Data sourced from [MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api/) and [Weather API](https://www.weatherapi.com/docs/)

<details>
  <summary> JSON request/response examples </summary>

Road Trip Request:
  ```
  {
    "origin": "denver,co",
    "destination": "orlando,fl",
    "api_key": "<user_api_key>"
  }
  ```

Road Trip Response:
  ```
  {
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "denver,co",
            "end_city": "orlando,fl",
            "travel_time": "25:07:14",
            "weather_at_eta": {
                "datetime": "2023-06-14 20:25:28 -0600",
                "temperature": 88.9,
                "condition": "Sunny"
            }
        }
    }
  }
  ```

</details>

### Book Search endpoint

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /book-search | location, quantity | Returns current weather in specified location along with a list of books about said location in a quantity indicated  | /api/v1/book-search?location=denver,co&quantity=5 |

Data sourced from [Weather API](https://www.weatherapi.com/docs/) and [Open Library Book Search API](https://openlibrary.org/dev/docs/api/search)

<details>
  <summary> JSON response example </summary>

Book Search and Forecast response:
  ```
  {
    "data": {
        "id": null,
        "type": "books",
        "attributes": {
            "destination": "denver,co",
            "forecast": {
                "summary": "Partly cloudy",
                "temperature": "62.4 F"
            },
            "total_books_found": 758,
            "books": [
                {
                    "isbn": [
                        "0762507845",
                        "9780762507849"
                    ],
                    "title": "Denver, Co",
                    "publisher": [
                        "Universal Map Enterprises"
                    ]
                },
                {
                    "isbn": [
                        "0607620056",
                        "9780607620054"
                    ],
                    "title": "Denver west, CO and Bailey, CO: Denver, CO",
                    "publisher": [
                        "USGS Branch of Distribution"
                    ]
                },
                {
                    "isbn": [
                        "9780607620047",
                        "0607620048"
                    ],
                    "title": "Denver East, CO and Castle Rock, CO: Denver, CO",
                    "publisher": [
                        "USGS Branch of Distribution"
                    ]
                },
                {
                    "isbn": [
                        "9780528952715",
                        "0528952714"
                    ],
                    "title": "Denver Regional, CO",
                    "publisher": [
                        "Rand McNally & Company"
                    ]
                },
                {
                    "isbn": [
                        "1427401683",
                        "9781427401687"
                    ],
                    "title": "University of Denver Co 2007",
                    "publisher": [
                        "College Prowler"
                    ]
                }
            ]
        }
    }
  }
  ```

</details>

### Background endpoint

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /background | location | Returns an image object based on the specified location | /api/v1/backgrounds?location=denver,co |

Data sourced from [Unsplash Image Search API](https://unsplash.com/documentation#search-photos)

<details>
  <summary> JSON response example </summary>

Background Search response:
  ```
  {
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "location": "denver,co",
            "image_url": "https://images.unsplash.com/photo-1677311275621-b3f6c1e8647b?ixid=M3w0NjEzMzJ8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2ODY2OTM2ODh8MA&ixlib=rb-4.0.3",
            "credit": {
                "source": "https://unsplash.com/photos/Wv9Azo02LAE",
                "author": "Gennady Zakharin",
                "logo": "https://images.unsplash.com/profile-fb-1668926194-2a1d353dcda1.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32"
            }
        }
    }
  }
  ```

</details>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### Contact

Isaac Thill - [![LinkedIn][linkedin-shield](https://www.linkedin.com/in/isaac-thill/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINK & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/isaac-thill/
[Pry-img]: https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[RSPEC-img]: https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Shoulda Matchers-img]: https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Simplecov-img]: https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[VCR-img]: https://img.shields.io/badge/vcr-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
