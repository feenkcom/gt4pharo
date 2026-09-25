Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoder >> asCoderViewModel [
	^ GtPharoMethodCoderViewModel new coder: self
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoder >> asExpandedOnlyElement [
	"Create an element for just the expanded coder without expander"

	^ GtPharoMethodCoderExpandedOnlyElement new
		textualCoderViewModel: self asCoderViewModel;
		yourself
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodCoder >> formatWithRequesterObject: aRequester [
	| ast originalSource formatted |
	originalSource := self currentSourceString.
	ast := [RBParser parseMethod: originalSource]
				on: RBParser gtParseErrorClass
				do: [:ex | ^self notifyParseError: ex requesterObject: aRequester].
	formatted := ast formattedCode.
	self currentSourceString: formatted.
	self
		updateSelectionAfterFormatOf: aRequester
		from: ast
		to: (RBParser parseMethod: formatted)
		originalSource: originalSource
		formattedSource: formatted
]
