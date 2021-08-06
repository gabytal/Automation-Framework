from behave import *
import requests
import logging
import urllib3

# disable urllib4 warning
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# configure logging
logs_format = '[%(asctime)s] %(levelname)s - %(message)s'
logger = logging.getLogger()
# this is needed in order to see the logs through K8s logs, #'/proc/1/fd/1' file is functioning as STDOUT.z
handler = logging.FileHandler('./results.log', mode='w')
logger.setLevel(logging.DEBUG)
formatter = logging.Formatter(logs_format)
handler.setFormatter(formatter)
logger.addHandler(handler)


@step('i want to send http get request to "{website}" and check that the response is "{desired_sc}"')
def connect_to_website(context, website, desired_sc):
    try:
        r = requests.get(website, verify=False)
        logger.info(f"Got Status Code: {r.status_code}")
    except Exception as e:
        r = False
        logger.error(f'Could not send request{e}')
    assert r, logger.error(
        f'The test has been failed, did not got response from the server')
    assert r.status_code == int(desired_sc), logger.error(
        f'The test has been failed, got {r.status_code} while expecting {desired_sc}')


@step('i want to send http get request to "{website}" and check that the response content equals "{desired_content}"')
def get_website_content(context, website, desired_content):
    try:
        r = requests.get(website, verify=False)
        logger.info(f"Got Content from response: {r.content}")
    except Exception as e:
        r = False
        logger.error(f'Could not send request{e}')
    assert r, logger.error(
        f'The test has been failed, did not got response from the server')
    assert str(r.content.decode("utf-8")) == desired_content, logger.error(
        f'The test has been failed, got {r.content} while expecting {desired_content}')
