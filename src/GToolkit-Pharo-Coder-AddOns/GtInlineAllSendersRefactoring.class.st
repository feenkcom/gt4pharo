Class {
	#name : #GtInlineAllSendersRefactoring,
	#superclass : #RBInlineAllSendersRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #transforming }
GtInlineAllSendersRefactoring >> inlineSelfSends [
	| methodsWithSenders |
	methodsWithSenders := ((self model allReferencesTo: selector)
			select: [ :each | each methodClass includesClass: class ])
			groupedBy: [ :each | each methodClass ].
	methodsWithSenders
		keysAndValuesDo: [ :cls :methods | 
			self initializePatternFor: cls.
			methods
				do: [ :each | 
					(cls = class and: [ each selector = selector ])
						ifFalse: [ self inlineMessagesInClass: each methodClass andSelector: each selector ] ] ]
]
