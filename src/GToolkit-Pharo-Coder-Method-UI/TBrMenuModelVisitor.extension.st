Extension { #name : #TBrMenuModelVisitor }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
TBrMenuModelVisitor >> visitPharoMethodCoderMenu: aMenuModel [
	^ self visitTextualCoderMenu: aMenuModel
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
TBrMenuModelVisitor >> visitPharoNewMethodCoderMenu: aMenuModel [
	^ self visitMenu: aMenuModel
]
