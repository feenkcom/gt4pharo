Class {
	#name : #GtPharoBigMethodExpandableSourceCoderElement,
	#superclass : #GtExpandableMethodCoderElement,
	#category : #'GToolkit-Pharo-Coder-BigMethods'
}

{ #category : #'private - instance creation' }
GtPharoBigMethodExpandableSourceCoderElement >> newExpandedElement [
	| anExpandedElement |
	anExpandedElement := GtPharoBigMethodExpandedSourceCoderElement new.

	textualCoderViewModel
		ifNotNil: [ :aCoder | self assignExpandedCoder: aCoder to: anExpandedElement ].

	^ anExpandedElement
]
