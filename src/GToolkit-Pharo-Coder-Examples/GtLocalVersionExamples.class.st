Class {
	#name : #GtLocalVersionExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-UI'
}

{ #category : #'as yet unclassified' }
GtLocalVersionExamples >> testGtBaseMethodHasTimestamp [
	<gtExample>
	| method localVersion timeStamp |
	
	method := BlElement>>#addChild:.
	localVersion := method gtLocalVersions first.
	timeStamp := method gtLocalVersions first timeStamp.
	
	self assert: timeStamp notNil.
	self 
		forPharo12AndNewer: [
			self assert: timeStamp ~= DateAndTime new ] 
		forPharo11: [	
			self assert: timeStamp = DateAndTime new ].
	
	^ localVersion
]

{ #category : #'as yet unclassified' }
GtLocalVersionExamples >> testPharoBaseMethodHasTimestamp [
	<gtExample>
	| method localVersion timeStamp |
	
	method := Object >> #at:.
	localVersion := method gtLocalVersions first.
	timeStamp := method gtLocalVersions first timeStamp.
	
	self assert: timeStamp notNil.
	self 
		forPharo12AndNewer: [
			self assert: timeStamp ~= DateAndTime new ] 
		forPharo11: [	
			self assert: timeStamp = DateAndTime new ].
	
	^ localVersion
]
