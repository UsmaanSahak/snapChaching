solr-8.0.0/bin/solr delete -c postsCore
solr-8.0.0/bin/solr delete -c commentsCore
solr-8.0.0/bin/solr create -c postsCore
solr-8.0.0/bin/solr create -c commentsCore

#create the fieldtypes.

#create the fields. date(compare to others), score/follows (int), participants (string array), posts (string array, with first being username, second being score, third being the text.), OP (string array, first being title, second being contents of post.)

#date - field: pdate
#rec - field: int
#participants - strings
#post - strings (username,title,text) //Escape all relevant characters, like \'
#comIds - ints (ids of comments to query the commentsCore)

#curl -X POST -H 'Content-type:application/json' --data-binary '{
#	"add-field-type":{
#		"name":"",
#		"class":"",
#		"analyzer":{
#			"tokenizer":{
#				"class":"",
#			},
#			"filters":[{
#				"class":"",
#			}],
#		}
#	}
#}' http://localhost:8983/solr/postsCore/schema
#
#curl -X POST -H 'Content-type:application/json' --data-binary '{
#	"add-field":{
#		"name":"",
#		"type":"",
#		"stored": true|false 
#	}
#}' http://localhost:8983/solr/postsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field-type":{
		"name":"keywordSearch",
		"class":"solr.TextField",
		"analyzer":{
			"tokenizer":{
				"class":"solr.LowerCaseTokenizerFactory",
			},
			"filters":[{
				"class":"solr.KStemFilterFactory",
			}],
		}
	}
}' http://localhost:8983/solr/postsCore/schema


curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"par",
		"type":"strings",
		"stored": true
	}
}' http://localhost:8983/solr/postsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"rec",
		"type":"pint",
		"stored": true 
	}
}' http://localhost:8983/solr/postsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"title",
		"type":"keywordSearch",
		"stored": true
	}
}' http://localhost:8983/solr/postsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"contents",
		"type":"keywordSearch",
		"stored": true
	}
}' http://localhost:8983/solr/postsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"OP",
		"type":"string",
		"stored": true
	}
}' http://localhost:8983/solr/postsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"comIDs",
		"type":"pints",
		"stored": true
	}
}' http://localhost:8983/solr/postsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"keywords",
		"type":"strings",
		"stored": true
	}
}' http://localhost:8983/solr/postsCore/schema







curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"rec",
		"type":"pint",
		"stored": true
	}
}' http://localhost:8983/solr/commentsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"user",
		"type":"string",
		"stored": true
	}
}' http://localhost:8983/solr/commentsCore/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
	"add-field":{
		"name":"contents",
		"type":"string",
		"stored": true
	}
}' http://localhost:8983/solr/commentsCore/schema



#Created fields
#postsCore
##par
##rec
##title
##contents
##OP
##comIDs

#commentsCore
#rec
#user
#contents

curl http://localhost:8983/solr/postsCore/config -H 'Content-type:application/json' -d'{
    set-property : {requestDispatcher.requestParsers.enableRemoteStreaming:true},
    set-property : {requestDispatcher.requestParsers.enableStreamBody:true}
}'
