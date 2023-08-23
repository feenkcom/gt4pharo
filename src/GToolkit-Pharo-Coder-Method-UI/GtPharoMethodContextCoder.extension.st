Extension { #name : #GtPharoMethodContextCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodContextCoder >> asCoderViewModel [
	^ (GtPharoMethodContextCoderViewModel new coder: self)
		selfObject: self context receiver
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoMethodContextCoder >> elementClass [
	^ GtExpandableContextMethodCoderElement
]
