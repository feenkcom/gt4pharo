Class {
	#name : #GtCoderNavigationExamplesWithScripter,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #accessing }
GtCoderNavigationExamplesWithScripter >> coderWithIndex [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ | index |
				index := GtCoderNavigationPackagesTagsClassesElement new
						navigationModel: GtCoderNavigationPackagesTagsClassesModel new.
				index navigationModel selectPackage: self class package .
				index navigationModel selectClass: self class.
				index].
	^ aScripter
]

{ #category : #accessing }
GtCoderNavigationExamplesWithScripter >> packageContextMenu [
	<gtExample>
	| aScripter |
	aScripter := self coderWithIndex.
	aScripter secondaryClick // GtCoderNavigationPackagesTreeElement;
		label: 'Open Package Context Menu';
		play.
		
	"aScripter assert
		label: 'Check menu contents';
		satisfies: [ :aThing |false ];
		onChildOfClass: BlElement;
		check."
	^ aScripter
]
