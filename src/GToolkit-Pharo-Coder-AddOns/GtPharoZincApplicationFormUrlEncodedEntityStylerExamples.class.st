"
Exemplify {{gtClass:GtPharoZincApplicationFormUrlEncodedEntityStyler}}.
"
Class {
	#name : #GtPharoZincApplicationFormUrlEncodedEntityStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Zinc'
}

{ #category : #examples }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> compiledMethod [
	<gtExample>
	^ self class >> #sourceCode
]

{ #category : #examples }
GtPharoZincApplicationFormUrlEncodedEntityStylerExamples >> sourceCode [
	<gtExample>
	^ ZnClient new
		url: 'https://example.com/auth/oauth/token' asZnUrl;
		entity:
			(ZnApplicationFormUrlEncodedEntity new
				at: 'grant_type' put: 'client_credentials';
				at: 'client_id' put: 'a client secret id';
				at: 'client_secret' put: 'client secret token';
				at: 'client_token' put: 'client secret token';
				yourself);
		accept: ZnMimeType applicationJson;
		yourself
]
