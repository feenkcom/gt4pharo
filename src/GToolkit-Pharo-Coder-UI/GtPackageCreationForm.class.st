Class {
	#name : #GtPackageCreationForm,
	#superclass : #GtCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtPackageCreationForm class >> componentName [
	^ 'Package'
]

{ #category : #accessing }
GtPackageCreationForm class >> priority [
	^ 3
]

{ #category : #callbacks }
GtPackageCreationForm >> commit [
	^ self commitPackage package
]

{ #category : #magritte }
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
						ifNotEmpty: [ (aPackage tagNamed: aValue tagName ifAbsent: [ nil ]) isNil ] ] ]
		labelled: 'Package and tag exist'
]

{ #category : #accessing }
GtPackageCreationForm >> selectInNavigationModel: aNavigationModel anInstance: anInstance [
	^ self packageAndTagName tagName
		ifEmpty: [ aNavigationModel selectPackage: anInstance ]
		ifNotEmpty: [ aNavigationModel
				selectPackageTag: (anInstance classTagNamed: self packageAndTagName tagName) ]
]

{ #category : #accessing }
GtPackageCreationForm >> toolFor: anInstance [
	^ GtPackageCoderTool package: anInstance
]
