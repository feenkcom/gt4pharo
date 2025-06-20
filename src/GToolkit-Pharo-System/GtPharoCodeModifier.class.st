"
# Pharo code modifier
Pharo does not support code modification from multiple threads, although it is not forbidden.
{{gtClass:GtPharoCodeModifier}} allows synchronisation of code modifications via a mutex.

All Pharo code changes should happen via this class

"
Class {
	#name : #GtPharoCodeModifier,
	#superclass : #Object,
	#instVars : [
		'monitor'
	],
	#classInstVars : [
		'current'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #'api - class' }
GtPharoCodeModifier class >> classComment: aString of: aBehavior [
	^ self current classComment: aString of: aBehavior
]

{ #category : #'api - method' }
GtPharoCodeModifier class >> compileMethodSource: aSourceCode in: aClass protocol: aMethodProtocol [
	^ self current compileMethodSource: aSourceCode in: aClass protocol: aMethodProtocol
]

{ #category : #'api - package' }
GtPharoCodeModifier class >> createPackageNamed: aPackageName [
	^ self current createPackageNamed: aPackageName
]

{ #category : #'api - class' }
GtPharoCodeModifier class >> createSubclassOf: anExistingClass named: aSubclassName package: aPackageSymbol [
	^ self current
		createSubclassOf: anExistingClass
		named: aSubclassName
		package: aPackageSymbol
]

{ #category : #accessing }
GtPharoCodeModifier class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #'api - package' }
GtPharoCodeModifier class >> registerPackage: aPackage [
	^ self current registerPackage: aPackage
]

{ #category : #'api - class' }
GtPharoCodeModifier class >> removeBehavior: aBehavior [
	^ self current removeBehavior: aBehavior
]

{ #category : #'api - class' }
GtPharoCodeModifier class >> removeBehaviorNamed: aBehaviorName [
	^ self current removeBehaviorNamed: aBehaviorName
]

{ #category : #'api - method' }
GtPharoCodeModifier class >> removeMethod: aCompiledMethod [
	^ self current removeMethod: aCompiledMethod
]

{ #category : #'api - package' }
GtPharoCodeModifier class >> removePackage: aPackage [
	^ self current removePackage: aPackage
]

{ #category : #'api - package' }
GtPharoCodeModifier class >> removePackageNamed: aPackageName [
	^ self current removePackageNamed: aPackageName
]

{ #category : #'api - package' }
GtPharoCodeModifier class >> removePackageTag: aPackageTag [
	^ self current removePackageTag: aPackageTag
]

{ #category : #'api - package' }
GtPharoCodeModifier class >> renamePackage: aPackage to: aNewPackageName [
	^ self current renamePackage: aPackage to: aNewPackageName
]

{ #category : #'api - package' }
GtPharoCodeModifier class >> unregisterPackage: aPackage [
	^ self current unregisterPackage: aPackage
]

{ #category : #'api - class' }
GtPharoCodeModifier >> classComment: aString of: aBehavior [
	^ self critical: [ aBehavior comment: aString ]
]

{ #category : #'api - method' }
GtPharoCodeModifier >> compileMethodSource: aSourceCode in: aClass protocol: aMethodProtocol [
	^ self critical: [
		aClass
			compile:aSourceCode
			classified: aMethodProtocol ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> createPackageNamed: aPackageName [
	^ self critical: [ RPackageOrganizer default createPackageNamed: aPackageName ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> createPackageTagOf: aPackage named: aTagName [
	<return: #RPackageTag>
	<exception: #RPackageConflictError>
	^ self critical: [ aPackage addClassTag: aTagName ]
]

{ #category : #'api - class' }
GtPharoCodeModifier >> createSubclassOf: anExistingClass named: aSubclassName instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aPackageSymbol [
	^ self
		critical: [ self
				forPharo12: [ 
					anExistingClass
						subclass: aSubclassName
						instanceVariableNames: instVarNameList
						classVariableNames: classVarNames
						package: aPackageSymbol ]
				forPharo11AndPharo10: [ anExistingClass
						subclass: aSubclassName
						instanceVariableNames: instVarNameList
						classVariableNames: classVarNames
						package: aPackageSymbol ] ]
]

{ #category : #'api - class' }
GtPharoCodeModifier >> createSubclassOf: anExistingClass named: aSubclassName instanceVariableNames: instVarNameList package: aPackageSymbol [
	^ self 
		createSubclassOf: anExistingClass
		named: aSubclassName
		instanceVariableNames: instVarNameList
		classVariableNames: ''
		package: aPackageSymbol
]

{ #category : #'api - class' }
GtPharoCodeModifier >> createSubclassOf: anExistingClass named: aSubclassName package: aPackageSymbol [
	^ self 
		createSubclassOf: anExistingClass
		named: aSubclassName
		instanceVariableNames: ''
		package: aPackageSymbol
]

{ #category : #'mutual exclusion' }
GtPharoCodeModifier >> critical: aBlock [
	^ monitor critical: [
		aBlock
			on: Exception
			do: [ :anException |
				"it is very important that the monitor is not locked when an exception happens"
				monitor exit.
				"after an #exit call the monitor is open for another process, so if users start to compile code
				from within the debugger. If debugger code compilation is not wrapped in this critical block,
				there might be a problem of code modification from multiple processes. The chance of this, however, is very slim."
				anException pass ] ]
]

{ #category : #'mutual exclusion' }
GtPharoCodeModifier >> deferFlushDuring: aBlock [
	^ self critical: [ SourceFiles deferFlushDuring: aBlock ]
]

{ #category : #initialization }
GtPharoCodeModifier >> initialize [
	super initialize.
	
	monitor := Monitor new
]

{ #category : #'api - method' }
GtPharoCodeModifier >> moveMethod: aMethod toExtensionPackage: aPackage [
	"We could use `aPackage methodCategoryPrefix` but it calls #asLowercase,
	which is something we do not do in other places."

	aMethod package = aPackage ifTrue: [ ^ aMethod ].

	^ self
		critical: [ 
			(GtMethodProtocolChange
				selector: aMethod selector
				in: aMethod methodClass
				classified: '*' , aPackage packageName) gtExecuteWithUndo.

			aMethod methodClass compiledMethodAt: aMethod selector ]
]

{ #category : #'api - refactoring' }
GtPharoCodeModifier >> performRefactoryChange: aRefactoryChange [
	^ self deferFlushDuring: [ aRefactoryChange gtExecuteWithUndo ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> registerPackage: aPackage [
	^ self critical: [ aPackage register ]
]

{ #category : #'api - class' }
GtPharoCodeModifier >> removeBehavior: aBehavior [
	^ self critical: [ aBehavior removeFromSystem ]
]

{ #category : #'api - class' }
GtPharoCodeModifier >> removeBehaviorNamed: aBehaviorName [
	^ self critical: [ (self class environment at: aBehaviorName ifAbsent: [ ^ self ]) removeFromSystem ]
]

{ #category : #'api - class' }
GtPharoCodeModifier >> removeClass: aClass [
	^ self critical: [ aClass removeFromSystem ]
]

{ #category : #'api - class' }
GtPharoCodeModifier >> removeClassNamed: aClassName [
	^ self removeBehaviorNamed: aClassName
]

{ #category : #'api - method' }
GtPharoCodeModifier >> removeMethod: aMethod [
	^ self critical: [ aMethod removeFromSystem ]
]

{ #category : #'api - method' }
GtPharoCodeModifier >> removeMethodFrom: aBehavior selector: aSelector [
	^ self
		critical: [ (RBRemoveMethodChange remove: aSelector from: aBehavior) gtExecuteWithUndo ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> removePackage: aPackage [
	^ self critical: [ aPackage removeFromSystem ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> removePackageNamed: aPackageName [
	^ self critical: [
		(self packageOrganizer
			packageNamed: aPackageName
			ifAbsent: [ ^ self ]) removeFromSystem ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> removePackageTag: aPackageTag [
	"Remove empty package tag.
	Note: Package tag must be without classes.
	Note: Use #removePackageTagIncludingClasses: if you want to remove also its classes."

	self critical: [ aPackageTag removeFromPackage ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> removePackageTagIncludingClasses: aPackageTag [
	"Remove package tag including its classes."
	
	self
		critical: [ 
			aPackageTag isEmpty ifFalse: [ 
				aPackageTag package removeClassesMatchingTag: aPackageTag ].
			aPackageTag removeFromPackage ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> renamePackage: aPackage to: aNewPackageName [
	^ self critical: [
		(aPackage organizer includesPackageNamed: aPackage name)
			ifTrue: [ aPackage renameTo: aNewPackageName ]
			ifFalse: [ aPackage name: aNewPackageName ] ]
]

{ #category : #'api - package' }
GtPharoCodeModifier >> unregisterPackage: aPackage [
	^ self critical: [ aPackage unregister ]
]
