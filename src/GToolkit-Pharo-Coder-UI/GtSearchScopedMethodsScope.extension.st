Extension { #name : #GtSearchScopedMethodsScope }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchScopedMethodsScope >> asFilterModelItem [
	^ GtFilterModelPluggableItem new
		icon: #icon;
		object: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchScopedMethodsScope >> icon [
	^ (self gtSafeIconNamed: self gtIconName) ifNotNil: #asElement
]
