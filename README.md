# HSL demo
HSL open API Robot Framework demo

## Purpose
This is small example project showing how to use [HSL open data routing API](https://digitransit.fi/en/developers/), Robot Framework, Allure and GitHub Actions.

## Usage

To be able to use the APIs, you need to register to [Digitransit](https://digitransit.fi/en/developers/api-registration/) and generate API key. API key should be saved to environment variable with name:

    DD_API_KEY

## Next steps:

### Install everything to local environment:

* Install Python 3.12 (probably works with other versions also, but not tested)
* Install Node.js (recommended version 20.x)
* Install Python libraries from the [requirements](./requirements.txt), example:

        pip install -r requirements.txt

* [Initialize the Browser library](https://robotframework-browser.org/#installation), follow the steps
* If you want use Allure, install also Java and [Allure](https://allurereport.org/docs/gettingstarted-installation/)

Run tests with Allure, example:

    robot -d results/   -v HEADLESS:true -v BROWSER:chromium --listener allure_robotframework   tests/tests.robot

* [Generate allure report](https://allurereport.org/docs/robotframework/#3-generate-a-report)

### Run tests in Docker container
Only allure-robotframework is included in the image, Allure and Java are not. 

* [Install Docker](https://docs.docker.com/engine/install/)
* In the root of project, build image: 

        sudo docker build -t <image-name-here> .
* Run tests in the container:


(© HSL 2024) & [Creative Commons BY 4.0 International Licence](https://creativecommons.org/licenses/by/4.0/)
