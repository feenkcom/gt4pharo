"
nil
"
Class {
	#name : #GtPackageAndTagName,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'tagName'
	],
	#category : #'GToolkit-Pharo-Coder-Models'
}

{ #category : #accessing }
GtPackageAndTagName >> copyWithNewPackageName: aPackageName [
	^ self copy packageName: aPackageName
]

{ #category : #'as yet unclassified' }
GtPackageAndTagName >> copyWithNewTagName: aTagName [
	^ self copy tagName: aTagName
]

{ #category : #accessing }
GtPackageAndTagName >> initialize [
	packageName := ''.
	tagName := ''
]

{ #category : #accessing }
GtPackageAndTagName >> isEmpty [
	^ packageName trim isEmpty
]

{ #category : #accessing }
GtPackageAndTagName >> packageName [

	^ packageName
]

{ #category : #accessing }
GtPackageAndTagName >> packageName: anObject [

	packageName := anObject
]

{ #category : #accessing }
GtPackageAndTagName >> printOn: aStream [
	aStream
		nextPutAll: packageName asString;
		nextPutAll: '-';
		nextPutAll: tagName asString
]

{ #category : #accessing }
GtPackageAndTagName >> tagName [

	^ tagName
]

{ #category : #accessing }
GtPackageAndTagName >> tagName: anObject [

	tagName := anObject
]
