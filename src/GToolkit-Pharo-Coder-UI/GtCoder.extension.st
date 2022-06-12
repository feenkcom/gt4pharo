Extension { #name : #GtCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoder class >> forClass: aClass [
	^ self forCoder: (GtPharoBehaviorCoder forClass: aClass)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoder class >> forCoder: aCoder [
	^ self basicNew initialize
		navigationModel: GtCoderNavigationModel default;
		pushCoder: aCoder
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoder class >> forMethod: aCompiledMethod [
    | classCoder coder |
    classCoder := GtPharoBehaviorCoder forClass: aCompiledMethod methodClass instanceSide.
    coder := self forCoder: classCoder.
    classCoder withSelectedMethod: aCompiledMethod.
    ^ coder
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoder class >> forObject: anObject [
	^ self forCoder: (GtPharoBehaviorCoder forObject: anObject)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoder class >> forPackage: anRPackage [
	^ self forCoder: (GtPharoPackageCoder forPackage: anRPackage)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoder class >> forPackageTag: anRPackageTag [
	^ self forCoder: (GtPharoPackageTagCoder forPackageTag: anRPackageTag)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoder class >> new [
	^ self forCoder: GtPharoPackagesCoder forAllPackages
]
