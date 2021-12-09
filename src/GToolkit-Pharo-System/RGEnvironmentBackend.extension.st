Extension { #name : #RGEnvironmentBackend }

{ #category : #'*GToolkit-Pharo-System' }
RGEnvironmentBackend >> subclassesFor: anRGBehavior [
	| result |

	result := IdentitySet new.

	anRGBehavior environment behaviorsDo: [ :each |
		(each superclass == anRGBehavior) ifTrue: [ result add: each] ].

	^ result asArray
]
