Class {
	#name : #GtPharoTemplateNamePartNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplateNamePartNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateNamePart: self
]

{ #category : #generated }
GtPharoTemplateNamePartNode >> name [
	^ name
]

{ #category : #generated }
GtPharoTemplateNamePartNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtPharoTemplateNamePartNode >> tokenVariables [
	^ #(#name)
]
