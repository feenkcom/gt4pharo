Extension { #name : #GtCoderElement }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forAllPackages [
	^ self forCoder: GtPharoPackagesCoder forAllPackages
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forClass: aClass [
	^ self forCoder: (GtPharoBehaviorCoder forClass: aClass)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forCoder: aCoder [
	^ self basicNew initialize
		navigationModel: GtCoderNavigationModel default;
		pushCoder: aCoder
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forMethod: aCompiledMethod [
    | classCoder coder |
    classCoder := GtPharoBehaviorCoder forClass: aCompiledMethod methodClass instanceSide.
    coder := self forCoder: classCoder.
    classCoder withSelectedMethod: aCompiledMethod.
    ^ coder
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forObject: anObject [
	^ self forCoder: (GtPharoBehaviorCoder forObject: anObject)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forObject: anObject method: aCompiledMethod [
	| classCoder coder |
	classCoder := GtPharoBehaviorCoder forObject: anObject.
	coder := self forCoder: classCoder.
	classCoder withSelectedMethod: aCompiledMethod.
	^ coder
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forPackage: anRPackage [
	^ self forCoder: (GtPharoPackageCoder forPackage: anRPackage)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> forPackageTag: anRPackageTag [
	^ self forCoder: (GtPharoPackageTagCoder forPackageTag: anRPackageTag)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderElement class >> new [
	^ self forCoder: GtPharoPackagesCoder forAllPackages
]
