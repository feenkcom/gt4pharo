Class {
	#name : #GtPharoZincStylerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Zinc'
}

{ #category : #examples }
GtPharoZincStylerExamples >> bearerSourceCode [
	<gtExample>
	^ ZnClient new
		url: 'https://example.com/api/info';
		setBearerAuthentication: 'secret token';
		yourself
]

{ #category : #examples }
GtPharoZincStylerExamples >> usernameAndPasswordSourceCode [
	<gtExample>
	^ ZnClient new
		username: 'joedoe' password: 'secret password';
		yourself
]
