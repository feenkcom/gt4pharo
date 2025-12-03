"
I define a method selector that may have a password as an argument.
I am used by {{gtClass:GtPharoMethodPasswordStyler}}.
#Examples
{{gtMethod:GtPharoMethodPasswordStyler >> #usernamePassword | expanded=true}}: 
{{gtMethod:GtPharoMethodPasswordStyler >> #setBearerAuthentication | expanded=true}}: 
"
Class {
	#name : #GtPharoMethodPasswordDefinition,
	#superclass : #Object,
	#instVars : [
		'selector',
		'position'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Zinc'
}

{ #category : #'node - testing' }
GtPharoMethodPasswordDefinition >> isForMessage: aMessage [

	self position ifNil: [ ^ false ].

	^ self selector = aMessage selector and: [ 
		  (self position between: 1 and: aMessage arguments size) and: [ 
			  | anArgument |
			  anArgument := aMessage arguments at: self position.
			  anArgument isLiteral and: [ anArgument isString ] ] ]
]

{ #category : #accessing }
GtPharoMethodPasswordDefinition >> position [

	^ position
]

{ #category : #accessing }
GtPharoMethodPasswordDefinition >> position: anInteger [

	position := anInteger
]

{ #category : #accessing }
GtPharoMethodPasswordDefinition >> selector [

	^ selector
]

{ #category : #accessing }
GtPharoMethodPasswordDefinition >> selector: aSymbol [

	selector := aSymbol
]

{ #category : #'node - accessing' }
GtPharoMethodPasswordDefinition >> startPositionFor: aMessage [

	"Return password start possition"

	^ (aMessage arguments at: self position) startPosition + 1
]

{ #category : #accessing }
GtPharoMethodPasswordDefinition >> stopPositionFor: aMessage [

	"Return password stop possition"

	^ (aMessage arguments at: self position) stopPosition - 1
]
