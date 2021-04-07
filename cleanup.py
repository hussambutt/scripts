def clean_docker():
  import requests
  base_url = 'http://artifacts.com/'

  headers = {
    'content-type': 'text/plain',
    }

  # data = 'items.find({"name":{"$eq":"manifest.json"},"stat.downloaded":{"$before":"24w"},"repo":{"$eq":"srx-docker-dev"}})'
  # data = 'items.find({"name":{"$eq":"manifest.json"},"repo":{"$eq":"srx-docker-dev"},"stat.downloads" : {"$eq" : null }, "created":{"$before":"24w"}})'
  data = 'items.find({"repo":{"$eq":"srx-dev-rpms"},"stat.downloads" : {"$eq" : null }, "created":{"$before":"52w"}})'


  myResp = requests.post(base_url+'api/search/aql', auth=('hussam.butt', 'XXXX'), headers=headers, data=data)

  for result in eval(myResp.text)["results"]:
    # print (result)
    artifact_url = base_url + result['repo'] + '/' + result['path'] + '/' + result['name']
    # if "latest" not in artifact_url and "master" not in artifact_url:
    if "maven-metadata.xml" not in artifact_url:
      print (artifact_url)
      print (requests.delete(artifact_url, auth=('hussam.butt', 'XXXX')))      # <----- [[[[[THIS WILL DELETE FILES]]]]]]
  
if __name__ == '__main__':
  clean_docker()
