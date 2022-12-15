"
nil
"
Class {
	#name : #GtPackageCreationForm,
	#superclass : #GtCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtPackageCreationForm >> commit [
	^ self commitPackage package
]

{ #category : #accessing }
GtPackageCreationForm >> packageAndTagDescription [
	<magritteDescription>
	^ super packageAndTagDescription
		addCondition: [ :aValue | 
			| aPackage |
			aPackage := aValue packageName asPackageIfAbsent: [ nil ].
			aPackage
				ifNil: [ true ]
				ifNotNil: [ aValue tagName
						ifEmpty: [ false ]
						ifNotEmpty: [ (aPackage classTagNamed: aValue tagName ifAbsent: [ nil ]) isNil ] ] ]
		labelled: 'Package and tag exist'
]
