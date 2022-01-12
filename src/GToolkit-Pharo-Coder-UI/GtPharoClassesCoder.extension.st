Extension { #name : #GtPharoClassesCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoClassesCoder >> asCoderViewModel [
	^ GtClassesCoderUIModel new coder: self
]
