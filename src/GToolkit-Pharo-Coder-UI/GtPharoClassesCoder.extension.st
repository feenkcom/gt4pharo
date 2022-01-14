Extension { #name : #GtPharoClassesCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoClassesCoder >> asCoderViewModel [
	^ GtClassesCoderViewModel new coder: self
]
