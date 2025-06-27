Class {
	#name : #GtRBClassPackageChange,
	#superclass : #RBClassCategoryChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #private }
GtRBClassPackageChange >> generateChanges [
	"Pharo 12"

	self primitiveExecute
]

{ #category : #private }
GtRBClassPackageChange >> primitiveExecute [
	| class |
	class := self changeClass.
	class classInstaller
		update: class
		to: [ :builder | 
			builder
				fillFor: class;
				category: category ]
]
