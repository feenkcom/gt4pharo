Class {
	#name : #GtMoveMethodRefactoring,
	#superclass : #RBMoveMethodRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtMoveMethodRefactoring >> checkAssignmentsToVariable [
	self isExpression ifFalse: [ super checkAssignmentsToVariable ]
]

{ #category : #accessing }
GtMoveMethodRefactoring >> getClassesToMoveTo [
	moveToClasses := (self options
			at: #variableTypesForReceiver
			ifAbsent: [ :ref :block | block value ])
			cull: self
			cull: [ self isExpression
					ifTrue: [ | ast |
						ast := RBParser parseExpression: variable.
						moveToClasses := {self model
									classNamed: ((ast isMessage and: [ ast selector = #new and: [ ast receiver isVariable ] ])
											ifTrue: [ ast receiver name ]
											ifFalse: [ #Object ])} ]
					ifFalse: [ super getClassesToMoveTo ].
				moveToClasses ]
]

{ #category : #accessing }
GtMoveMethodRefactoring >> isExpression [
	^ (RBScanner isVariable: variable) not
]
