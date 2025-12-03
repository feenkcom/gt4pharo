Class {
	#name : #GtCoderExampleStatusStyler,
	#superclass : #GtGenericPharoStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-Example status'
}

{ #category : #'method coder styler' }
GtCoderExampleStatusStyler class >> examplePatternStylerFor: aMethodCoder [
	<gtMethodCoderPatternStyler: 5>
	aMethodCoder example isNil
		ifTrue: [ ^ nil ].
	^ self new
		coder: aMethodCoder;
		classOrMetaClass: aMethodCoder classOrMetaClass;
		yourself
]

{ #category : #generated }
GtCoderExampleStatusStyler >> visitMethod: aMethodNode [
	| currentExample |

	currentExample := self coderViewModel coderModel example.
	currentExample
		ifNil: [ ^ self ].
	
	self
		attribute: (GtCoderExampleStatusAttribute forExample: currentExample)
		from: aMethodNode pattern stopPosition
		to: aMethodNode pattern stopPosition
]
