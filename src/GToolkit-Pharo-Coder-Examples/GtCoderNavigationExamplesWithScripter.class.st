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
GtCoderNavigationExamplesWithScripter >> elementHasSelectionBackground: anElement [
	^ anElement withAllParents
		anySatisfy: [ :p | 
			p background class = BlPaintBackground
				and: [ p background paint color = BrGlamorousColors selectedListItemColor ] ]
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

{ #category : #accessing }
GtCoderNavigationExamplesWithScripter >> scripter: scripter hasTextSelection: aString [
	scripter assert
		// BlTextElement;
		anySatisfy: [ :l | l text asString = aString and: [ self elementHasSelectionBackground: l ] ];
		play
]

{ #category : #accessing }
GtCoderNavigationExamplesWithScripter >> selectPackageWithExtension [
	<gtExample>
	| scripter model pkg |
	scripter := self coderWithIndex.
	model := scripter element navigationModel.
	pkg := 'GToolkit-Pharo-Coder' asPackage.
	model selectPackage: pkg.
	scripter continue.
	model selectPackageTag: (GtCoderPackageExtensionTag forPackage: pkg).
	scripter continue.
	model selectClass: RBRenameClassChange.
	scripter continue.
	self scripter: scripter hasTextSelection: 'Extensions'.
	self scripter: scripter hasTextSelection: 'RBRenameClassChange'.
	self scripter: scripter hasTextSelection: '*GToolkit-Pharo-Coder'.
	^ scripter
]

{ #category : #accessing }
GtCoderNavigationExamplesWithScripter >> selectSuperclassOfPackageWithExtension [
	<gtExample>
	| scripter model pkg tag |
	scripter := self selectPackageWithExtension.
	model := scripter element navigationModel.
	pkg := 'Refactoring-Changes' asPackage.
	tag := pkg classTagNamed: 'Changes-Classes'.
	model selectClass: RBRefactoryDefinitionChange.
	scripter continue.
	self scripter: scripter hasTextSelection: 'Changes-Classes'.
	self scripter: scripter hasTextSelection: 'RBRefactoryDefinitionChange'.
	^ scripter
]
