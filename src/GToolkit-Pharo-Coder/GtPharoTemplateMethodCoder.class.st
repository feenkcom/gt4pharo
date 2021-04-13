Class {
	#name : #GtPharoTemplateMethodCoder,
	#superclass : #GtPharoSourceCoder,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #converting }
GtPharoTemplateMethodCoder >> asCoderUIModel [
	^ GtPharoTemplateMethodCoderViewModel new coderModel: self
]

{ #category : #'api - ast' }
GtPharoTemplateMethodCoder >> computeAst: theSourceString [
	^ GtPharoTemplateParser
		parseWithErrors: theSourceString
		startingAt: GtPharoTemplateParser startingStateForMethod
]

{ #category : #'initialize-release' }
GtPharoTemplateMethodCoder >> forSource: aString [
	self sourceCode: (GtCoderExplicitSourceCode new source: aString)
]
