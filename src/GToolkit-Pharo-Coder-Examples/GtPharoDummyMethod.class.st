Class {
	#name : #GtPharoDummyMethod,
	#superclass : #GtPharoDummy,
	#instVars : [
		'dummyClass',
		'realMethod',
		'selector',
		'protocol'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #'api - inst vars' }
GtPharoDummyMethod >> anyInstVarName [
	<return: #Symbol>

	^ self dummyClass anyInstVarName
]

{ #category : #'api - class' }
GtPharoDummyMethod >> className [
	^ self dummyClass className
]

{ #category : #accessing }
GtPharoDummyMethod >> dummyClass [
	^ dummyClass
]

{ #category : #accessing }
GtPharoDummyMethod >> dummyClass: anObject [
	dummyClass := anObject
]

{ #category : #'gt - extensions' }
GtPharoDummyMethod >> gtCoderFor: aView [
	<gtView>
	| aRealMethod |

	(aRealMethod := realMethod) ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Coder';
		priority: 5;
		stencil: [ GtCoderElement forMethod: aRealMethod ]
]

{ #category : #'gt - extensions' }
GtPharoDummyMethod >> gtPackagesViewChildren [
	^ #()
]

{ #category : #'gt - extensions' }
GtPharoDummyMethod >> gtPackagesViewItemText [
	^ self selector
]

{ #category : #testing }
GtPharoDummyMethod >> isKeyword [
	^ self selector isKeyword
]

{ #category : #testing }
GtPharoDummyMethod >> isUnary [
	^ self selector isUnary
]

{ #category : #accessing }
GtPharoDummyMethod >> protocol [
	^ protocol
]

{ #category : #accessing }
GtPharoDummyMethod >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
GtPharoDummyMethod >> protocolName [
	^ self protocol
]

{ #category : #'api - class' }
GtPharoDummyMethod >> realClass [
	<return: #Class>

	^ self dummyClass realClass
]

{ #category : #accessing }
GtPharoDummyMethod >> realMethod [
	^ realMethod
]

{ #category : #accessing }
GtPharoDummyMethod >> realMethod: anObject [
	realMethod := anObject
]

{ #category : #accessing }
GtPharoDummyMethod >> selector [
	^ selector
]

{ #category : #accessing }
GtPharoDummyMethod >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
GtPharoDummyMethod >> systemMethod [
	^ self realClass >> self selector
]
