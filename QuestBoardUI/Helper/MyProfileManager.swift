//
//  MyProfileManager.swift
//  QuestBoardUI
//
//  Created by Yong Jia on 27/4/21.
//

import Foundation

public class MyProfileManager {
    static var myProfile: MyProfile?
    static var everydayProfile: EverydayProfile?
    static var skillsetProfiles: [SkillsetProfile]?
    static var profileIsInitialised: Bool = false
    static var isEverydayProfileSetup: Bool = false
    
    init() {}
    
    static func initMyProfileManager() {
        print(NetworkManager.isInitialised)
        print(NetworkManager.nToken)
        NetworkManager.call(url: "/get-user-full-profile", json: ["empty":"emptyToken"], Completion: {(response) in
            print(response)
            
            let everydayProfile = EverydayProfile()
            if let everydayProfileDict = response["everydayProfile"] as? [String: Any] {
                everydayProfile.id = everydayProfileDict["id"] as? Int
                everydayProfile.userId = everydayProfileDict["userId"] as? Int
                everydayProfile.level = everydayProfileDict["level"] as? Int
                everydayProfile.exp = everydayProfileDict["exp"] as? Int
                everydayProfile.title = everydayProfileDict["title"] as? String
                isEverydayProfileSetup = true
            }
            
            let myProfile = MyProfile()
            if let myProfileDict = response["myProfile"] as? [String: Any] {
                myProfile.id = myProfileDict["id"] as? Int
                myProfile.userName = myProfileDict["userName"] as? String
                myProfile.email = myProfileDict["email"] as? String
                myProfile.ssoUid = myProfileDict["ssoUid"] as? String
                myProfile.active = myProfileDict["active"] as? Bool
                myProfile.registerType = myProfileDict["registerType"] as? Int
                myProfile.createdDate = myProfileDict["createdDate"] as? String
                myProfile.updatedDate = myProfileDict["updatedDate"] as? String
            }
            
            var skillProfiles: [SkillsetProfile] = [SkillsetProfile]()
            if let skillProfileJSON = response["skillProfile"] as? [Any] {
                for ss in skillProfileJSON {
                    if let singleSkillSetRec = ss as? [String: Any] {
                        let skillProfile = SkillsetProfile()
                        for (key, value) in singleSkillSetRec {
                            let ssp = value as! [String: Any]
                            if key == "skillSetProfile" {
                                skillProfile.skillSetProfileId = ssp["id"] as? Int
                                skillProfile.userId = ssp["userId"] as? Int
                                skillProfile.skill = ssp["skill"] as? String
                                skillProfile.skillDesc = ssp["skillDesc"] as? String
                                skillProfile.skillEndorsed = ssp["skillEndorsed"] as? Int
                                skillProfile.display = ssp["display"] as? Bool
                                skillProfile.createdDate = ssp["createdDate"] as? String
                                skillProfile.updatedDate = ssp["updatedDate"] as? String
                            } else if key == "professionalLevel" {
                                skillProfile.professionaLevelId = ssp["id"] as? Int
                                skillProfile.professionalTitle = ssp["title"] as? String
                                skillProfile.professionalLevel = ssp["level"] as? Int
                                skillProfile.professionalExp = ssp["exp"] as? Int
                            }
                        }
                        skillProfiles.append(skillProfile)
                    }
                }
            }
            MyProfileManager.everydayProfile = everydayProfile
            MyProfileManager.myProfile = myProfile
            MyProfileManager.skillsetProfiles = skillProfiles
            
            MyProfileManager.profileIsInitialised = true
        })
    }
}
