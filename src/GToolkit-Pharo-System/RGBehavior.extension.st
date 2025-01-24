Extension { #name : #RGBehavior }

{ #category : #'*GToolkit-Pharo-System' }
RGBehavior >> asEpiceaRingDefinition [

	^ self
]

{ #category : #'*GToolkit-Pharo-System' }
RGBehavior >> inheritsFrom: aClass [ 
	<gtPharoPatch: #Pharo>
	"Answer whether the argument, aClass, is on the receiver's superclass 
	chain."
	| aSuperclass |

	aSuperclass := self superclass.
	[ aSuperclass == nil ]
		whileFalse: [
			| aNextSuperclass |
			aSuperclass == aClass
				ifTrue: [ ^true ].
				
			aNextSuperclass := aSuperclass superclass.
			(aNextSuperclass isNil or: [ aNextSuperclass == aSuperclass ])
				ifTrue: [ ^ false ].
			aSuperclass := aNextSuperclass ].
	^false
]

{ #category : #'*GToolkit-Pharo-System' }
RGBehavior >> subclasses [
	<gtPharoPatch: #Pharo>
	
	^ self backend forBehavior subclassesFor: self
]
