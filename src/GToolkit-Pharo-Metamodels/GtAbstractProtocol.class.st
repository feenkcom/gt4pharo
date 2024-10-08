Class {
	#name : #GtAbstractProtocol,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Metamodels-Protocols'
}

{ #category : #accessing }
GtAbstractProtocol >> allMethods [
	<return: #Collection of: #CompiledMethod>

	^ self subclassResponsibility
]

{ #category : #testing }
GtAbstractProtocol >> canBeRemoved [
	^ self isEmpty
]

{ #category : #testing }
GtAbstractProtocol >> canBeRenamed [
	^ true
]

{ #category : #testing }
GtAbstractProtocol >> isVirtualProtocol [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAbstractProtocol >> name [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAbstractProtocol >> protocolClass [
	^ self subclassResponsibility
]
