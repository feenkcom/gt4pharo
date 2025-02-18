Extension { #name : #BrGlamorousMenuElementBuilder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
BrGlamorousMenuElementBuilder >> visitPharoMethodCoderMenu: aMenuModel [
	| aCoderElement |
	aCoderElement := self visitTextualCoderMenu: aMenuModel.
	
	aCoderElement ifNotNil: [ 
		aCoderElement coderViewModel 
			selfObjectHolder: aMenuModel selfObjectHolder ].
	
	^ aCoderElement
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
BrGlamorousMenuElementBuilder >> visitPharoNewMethodCoderMenu: aMenuModel [
	| aNewMethodElement |
	aMenuModel ensureCoderViewModel.
	aNewMethodElement := GtPharoNewMethodCoderElement new
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			behavior: aMenuModel behavior;
			methodCoderViewModelValueHolder: aMenuModel valueHolder;
			onMethodCoderSaved: aMenuModel onMethodCoderSaved;
			when: GtPhlowObjectToSpawn do: aMenuModel onObjectToSpawn.
	aNewMethodElement
		addAptitude: (BrGlamorousMenuPinnableAptitude new
				menuModel: aMenuModel;
				withResizers;
				withAllPinActions).
	aNewMethodElement addAptitude: BrMenuCommonAptitude new.
	aNewMethodElement addAptitude: (BrMenuHideableAptitude new 
		menuModel: aMenuModel).

	^ aNewMethodElement
]
