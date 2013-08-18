import urllib2
import json

def test1():
   url = ('https://ajax.googleapis.com/ajax/services/search/images?' +
          'v=1.0&q=thomas%20bayes&userip=INSERT-USER-IP')

   request = urllib2.Request(url, None, {'Referer': 'www.INSERT-USER-SITE.com'})
   response = urllib2.urlopen(request)

   # Process the JSON string.
   results = json.load(response)
   # now have some fun with the results...

   y = results['responseData']['results']

   for i in y:
      print i['url']

def test2():
   url = "http://www.amazon.com/First-Course-Database-Systems-Edition/dp/013600637X"

   request = urllib2.Request(url, None, {'Referer': 'www.INSERT-USER-SITE.com'})
   response = urllib2.urlopen(request)

   results = response.read()
   print results
   
