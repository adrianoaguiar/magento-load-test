# Load Test Scenarios for Magento 1 and Magento 2

This scenarios were used to perform load test for Magento 1 and Magento 2 applications in different environments.
Results are publicly available on [MageCore blog](https://www.magecore.com/blog):

- [Magento CE 1.9 vs Magento CE 2.0 Performance Comparison](https://www.magecore.com/blog/news/magento-ce-1-9-vs-magento-ce-2-0-performance-comparison)
- [How Does PHP 7 Affects Performance of Magento 1.9 CE vs. Magento 2.0 CE](https://www.magecore.com/blog/news/php-7-affects-performance-magento-1-9-ce-vs-magento-2-0-ce)

## Repository Structure

Tests are grouped in application folders which include following assets:
- media - image files used for catalog products
- media.sh - script that initialize application media based on catalog and images from media folder
- data.sql.gz - database dump
- gatling - load test scenarios for [Gatling](http://gatling.io/) load testing framework

## Environment Configuration

- OS: Amazon Linux AMI 2015.03
- Web server: nginx/1.8.0 + php-fpm
- PHP: 5.5.30 or 7.0.3
- Varnish: 3.0.5
- Redis: 3.0.5
- Database: MySQL 5.6.27

## Setup instructions

- Create database and import dump from data.sql.gz of proper application
- Install Magento application using database created on the previous step
- Initialize catalog media by running ``media.sh``
- [Install](http://gatling.io/docs/2.2.0/quickstart.html#installing) Gatling
- Run gatling scenario using following options
| Option |	Description | Default Value |
|--------|-------------|----------------|
| dataDir | Data directory used in test scenarios | magento | 
| users	 | The number of concurrent users | 20 |
| ramp | Increase load to number of users in, sec | 30 |
| during | Run test during period, minutes | 10 |
| domain | Testing domain name | magento.test.com | 
| useSecure | Use HTTPS for secure pages | 0 |
| project | Project Name for Report | Magento | 
