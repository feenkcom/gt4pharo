Extension { #name : #Number }

{ #category : #'*GToolkit-Pharo-Coder' }
Number >> gtLiteralValueMatch [
	^ GtSearchLiteralValueFilter forValue: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
Number >> gtReferences [
	^ GtSearchReferencesFilter literal: self
]
