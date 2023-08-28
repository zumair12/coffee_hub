# Coffee Hub

Coffee Hub is a Ruby on Rails web application for managing coffee orders.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Running the Server](#running-the-server)
- [Running Sidekiq](#running-sidekiq)
- [Running Test Cases](#running-test-cases)
- [Demo Video](#demo-video)

## Introduction

Coffee Hub is a web application built with Ruby on Rails to handle coffee orders and manage items, discounts, and customers. It provides a user-friendly interface to create, view, and manage orders.

## Features

- Create coffee orders
- Add and Delete items with prices and tax rates
- Apply discounts to orders based on items
- Track order states (e.g., processing, delivered)
- Responsive and user-friendly interface
- Real-time updates using Action Cable for order notifications
- Background job processing with Sidekiq

## Requirements

- Ruby 3.2.1
- Rails 7.0.4 or higher
- Redis server (for Action Cable and Sidekiq)

## Installation

1. Clone the repository:

git clone https://github.com/yourusername/coffee_hub.git
cd coffee_hub


2. Install dependencies:

bundle install


## Usage

Before running the application, make sure you have set up the required database and environment variables. You can find the database configuration in `config/database.yml`.

1. Create the database:

rails db:create


2. Run database migrations:

rails db:migrate


4. Start the Rails server:

rails s


5. Access the application in your web browser:

http://localhost:3000


The application will be accessible at `http://localhost:3000` in your web browser.

## Running Sidekiq

Coffee Hub uses Sidekiq for background job processing. To run Sidekiq, use the following command:

bundle exec sidekiq


## Running Test Cases

To run the test cases for Coffee Hub, use the following command:

bundle exec rspec spec

## Demo Video

Watch the demo of Coffee Hub in action: [Demo Video](https://www.loom.com/share/81bdad07b8434e3eaf04933bc11987ec)