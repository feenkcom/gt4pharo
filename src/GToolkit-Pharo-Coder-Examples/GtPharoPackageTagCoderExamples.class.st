Class {
	#name : #GtPharoPackageTagCoderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #'examples - rename' }
GtPharoPackageTagCoderExamples >> renamePreviewHiddenForTheSameName [
	"The rename preview of the package tag coder is hidden again when the typed name is the tag name
	(the text is a String, the tag name a Symbol)"

	<gtExample>
	<return: #GtRefactoringsInDropdownPreviewElement>
	| element editor preview tagName |
	tagName := self class packageTag name.
	element := (GtPharoPackageTagCoder forPackageTag: self class packageTag) asElement.
	element
		allChildrenBreadthFirstDo: [ :each | 
			(editor isNil and: [ (each isKindOf: BrEditableLabel) and: [ each text asString = tagName asString ] ])
				ifTrue: [ editor := each ].
			(preview isNil and: [ each isKindOf: GtRefactoringsInDropdownPreviewElement ])
				ifTrue: [ preview := each ] ].
	self assert: preview visibility class equals: BlVisibilityGone.

	editor text: (tagName , 'X') asRopedText.
	editor editor deleter
		from: editor text size - 1 to: editor text size;
		delete.
	self assert: editor text asString equals: tagName asString.
	self assert: preview visibility class equals: BlVisibilityGone.
	^ preview
]
