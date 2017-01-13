import json

json_file = open('yelp_academic_dataset.json','rU')
output = []
for line in json_file:
    json_data = json.loads(line)
    if(json_data['type']=='business'):
        name = json_data['name'].encode('utf-8')
        city = json_data.get('city','NA').encode('utf-8')
        state = json_data.get('state','NA').encode('utf-8')
        stars = str(json_data.get('stars','NA')).encode('utf-8')
        review_count = str(json_data.get('review_count','NA')).encode('utf-8')
        try:
            main_category = json_data.get('categories', ['NA'])[0].encode('utf-8')
        except IndexError:
            main_category = 'NA'.encode('utf-8')
        output.append((name,city,state,stars,review_count,main_category))

header = ('name','city','state','stars','review_count','main_category')
output_file = open("businessdata.tsv",'w')
output_file.write('\t'.join(header)+'\n')
for item in output:
    output_file.write('\t'.join(item)+'\n')
output_file.close()