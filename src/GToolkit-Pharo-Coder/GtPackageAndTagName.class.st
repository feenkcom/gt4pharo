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
GtPackageAndTagName >> category [
	^ self packageName asString
		, (self tagName isEmpty ifTrue: [ '' ] ifFalse: [ '-' , self tagName ])
]

{ #category : #accessing }
GtPackageAndTagName >> copyWithNewPackageName: aPackageName [
	^ self copy packageName: aPackageName
]

{ #category : #'as yet unclassified' }
GtPackageAndTagName >> copyWithNewTagName: aTagName [
	^ self copy tagName: aTagName
]

{ #category : #accessing }
GtPackageAndTagName >> defaultPackageName [
	^ 'PackageName'
]

{ #category : #accessing }
GtPackageAndTagName >> defaultTagName [
	^ 'TagName'
]

{ #category : #accessing }
GtPackageAndTagName >> fullName [
	^ self packageName asString, '-', self tagName asString
]

{ #category : #accessing }
GtPackageAndTagName >> initialize [
	packageName := ''.
	tagName := ''
]

{ #category : #accessing }
GtPackageAndTagName >> isEmpty [
	^ self packageName trim isEmpty
]

{ #category : #accessing }
GtPackageAndTagName >> packageName [

	^ packageName ifNil: [ packageName := '' ]
]

{ #category : #accessing }
GtPackageAndTagName >> packageName: anObject [

	packageName := anObject
]

{ #category : #accessing }
GtPackageAndTagName >> packageRope [
	^ self packageName asRopedText
		ifEmpty: [ self packageName asRopedText
				attribute: (BrGhostTextAttribute
						for: (self defaultPackageName asRopedText glamorousFormEditorCodeFontAndSize
								foreground: Color lightGray)) ]
]

{ #category : #accessing }
GtPackageAndTagName >> printOn: aStream [
	aStream
		nextPutAll: self fullName
]

{ #category : #accessing }
GtPackageAndTagName >> tagName [

	^ tagName ifNil: [ tagName := '' ]
]

{ #category : #accessing }
GtPackageAndTagName >> tagName: anObject [

	tagName := anObject
]

{ #category : #accessing }
GtPackageAndTagName >> tagRope [
	^ self tagName asRopedText
		ifEmpty: [ self tagName asRopedText
				attribute: (BrGhostTextAttribute
						for: (self defaultTagName asRopedText glamorousFormEditorCodeFontAndSize
								foreground: Color lightGray)) ]
]
