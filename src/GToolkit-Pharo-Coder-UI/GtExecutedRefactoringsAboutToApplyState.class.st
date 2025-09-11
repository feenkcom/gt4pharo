Class {
	#name : #GtExecutedRefactoringsAboutToApplyState,
	#superclass : #GtExecutedRefactoringsState,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - state' }
GtExecutedRefactoringsAboutToApplyState >> ifApplyingDo: aBlock [
	aBlock value
]

{ #category : #'api - state' }
GtExecutedRefactoringsAboutToApplyState >> running: aPromise [
	^ GtExecutedRefactoringsState running: aPromise
]
