

import requests
from bs4 import BeautifulSoup

url = "https://alerts.weather.gov/cap/ny.php?x=3"
html_text = requests.get(url)
soup = BeautifulSoup(html_text.content, features = "lxml")

print(soup.prettify())
