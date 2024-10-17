Extension { #name : #GtSearchScopedMethodsAllScope }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchScopedMethodsAllScope >> icon [
	^ BlElement new
		size: 16 @ 16;
		geometry: BlCircleGeometry new;
		border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1)
]
