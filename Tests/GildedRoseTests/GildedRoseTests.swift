import XCTest
@testable import GildedRose

final class GildedRoseTests: XCTestCase {
    
    func test_actualItems() {
        
        let items = [
            Item(name: "+5 Dexterity Vest", sellIn: 10, quality: 20),
            Item(name: "Aged Brie", sellIn: 2, quality: 0),
            Item(name: "Elixir of the Mongoose", sellIn: 5, quality: 7),
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 80),
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: -1, quality: 80),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 20),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 49),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 49),
            Item(name: "Conjured Mana Cake", sellIn: 3, quality: 6),
        ]
        
        let app = GildedRose(items: items)
                
        XCTAssertEqual(10, items[0].sellIn)
        XCTAssertEqual(20, items[0].quality)
        
        XCTAssertEqual(2, items[1].sellIn)
        XCTAssertEqual(0, items[1].quality)
        
        XCTAssertEqual(5, items[2].sellIn)
        XCTAssertEqual(7, items[2].quality)
        
        XCTAssertEqual(0, items[3].sellIn)
        XCTAssertEqual(80, items[3].quality)
        
        XCTAssertEqual(-1, items[4].sellIn)
        XCTAssertEqual(80, items[4].quality)
        
        XCTAssertEqual(15, items[5].sellIn)
        XCTAssertEqual(20, items[5].quality)
        
        XCTAssertEqual(10, items[6].sellIn)
        XCTAssertEqual(49, items[6].quality)
        
        XCTAssertEqual(5, items[7].sellIn)
        XCTAssertEqual(49, items[7].quality)
        
        XCTAssertEqual(3, items[8].sellIn)
        XCTAssertEqual(6, items[8].quality)
        
        app.updateQuality()
        
        XCTAssertEqual(9, items[0].sellIn)
        XCTAssertEqual(19, items[0].quality)
        
        XCTAssertEqual(1, items[1].sellIn)
        XCTAssertEqual(1, items[1].quality)
        
        XCTAssertEqual(4, items[2].sellIn)
        XCTAssertEqual(6, items[2].quality)
        
        XCTAssertEqual(0, items[3].sellIn)
        XCTAssertEqual(80, items[3].quality)
        
        XCTAssertEqual(-1, items[4].sellIn)
        XCTAssertEqual(80, items[4].quality)
        
        XCTAssertEqual(14, items[5].sellIn)
        XCTAssertEqual(21, items[5].quality)
        
        XCTAssertEqual(9, items[6].sellIn)
        XCTAssertEqual(50, items[6].quality)
        
        XCTAssertEqual(4, items[7].sellIn)
        XCTAssertEqual(50, items[7].quality)
        
        XCTAssertEqual(2, items[8].sellIn)
        XCTAssertEqual(4, items[8].quality)
    }

    func test_normalItems() {
        
        let items = [
            // Item where quality drops to 0 after sellIn date passed
            Item(name: "+5 Dexterity Vest", sellIn: 2, quality: 5),
            // Item where quality drops to 0 before sellIn date passed
            Item(name: "Elixir of the Mongoose", sellIn: 3, quality: 1),
        ]
        
        let app = GildedRose(items: items)
                
        XCTAssertEqual(2, items[0].sellIn, "Expect sellIn to be initial value of 2")
        XCTAssertEqual(5, items[0].quality, "Expect quality to be initial value of 5")
        
        XCTAssertEqual(3, items[1].sellIn, "Expect sellIn to be initial value of 3")
        XCTAssertEqual(1, items[1].quality, "Expect quality to be initial value of 1")

        app.updateQuality()
        
        XCTAssertEqual(1, items[0].sellIn, "Expect sellIn after 1 day to be 1")
        XCTAssertEqual(4, items[0].quality, "Expect quality after 1 day to be 4")
        
        XCTAssertEqual(2, items[1].sellIn, "Expect sellIn after 1 day to be 2")
        XCTAssertEqual(0, items[1].quality, "Expect quality can't be less then 0")
        
        app.updateQuality()
        
        XCTAssertEqual(0, items[0].sellIn, "Expect sellIn after 2 days to be 0")
        XCTAssertEqual(3, items[0].quality, "Expect quality after 2 days to be 3")
        
        XCTAssertEqual(1, items[1].sellIn, "Expect sellIn after 2 days to be 1")
        XCTAssertEqual(0, items[1].quality, "Expect quality can't be less then 0")
        
        app.updateQuality()
               
        XCTAssertEqual(-1, items[0].sellIn, "Expect sellIn after 3 days to be passed sellIn date and be -1")
        XCTAssertEqual(1, items[0].quality, "Expect quality after sellIn date to lower quality twice as fast and be 1")
        
        app.updateQuality()
               
        XCTAssertEqual(-2, items[0].sellIn, "Expect sellIn after 4 days to be passed sellIn date and be -2")
        XCTAssertEqual(0, items[0].quality, "Expect quality can't be less then 0")
    }
    
    func test_sulfurasItems() {
        
        let items = [
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 80),
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: -1, quality: 80),
        ]
        
        let app = GildedRose(items: items)
                
        XCTAssertEqual(0, items[0].sellIn, "Expect sellIn to be initial value of 0")
        XCTAssertEqual(80, items[0].quality, "Expect quality to be initial value of 80")
        
        XCTAssertEqual(-1, items[1].sellIn, "Expect sellIn to be initial value of -1")
        XCTAssertEqual(80, items[1].quality, "Expect quality to be initial value of 80")

        app.updateQuality()
        
        XCTAssertEqual(0, items[0].sellIn, "Expect sellIn to still be initial value of 0 after update")
        XCTAssertEqual(80, items[0].quality, "Expect quality to still be initial value of 80 after update")
        
        XCTAssertEqual(-1, items[1].sellIn, "Expect sellIn to still be initial value of -1 after update")
        XCTAssertEqual(80, items[1].quality, "Expect quality to still be initial value of 80 after update")
    }
    
    func test_agedBrieItems() {
        
        let items = [
            Item(name: "Aged Brie", sellIn: 2, quality: 0),
            Item(name: "Aged Brie", sellIn: 1, quality: 49),
        ]
        
        let app = GildedRose(items: items)
                
        XCTAssertEqual(2, items[0].sellIn, "Expect sellIn to be initial value of 2")
        XCTAssertEqual(0, items[0].quality, "Expect quality to be initial value of 0")
        
        XCTAssertEqual(1, items[1].sellIn, "Expect sellIn to be initial value of 1")
        XCTAssertEqual(49, items[1].quality, "Expect quality to be initial value of 49")

        app.updateQuality()
        
        XCTAssertEqual(1, items[0].sellIn, "Expect sellIn after 1 day to be 1")
        XCTAssertEqual(1, items[0].quality, "Expect quality after 1 day to be 1")
        
        XCTAssertEqual(0, items[1].sellIn, "Expect sellIn after 1 day to be 0")
        XCTAssertEqual(50, items[1].quality, "Expect quality after 1 day to be 50")
        
        app.updateQuality()
        
        XCTAssertEqual(0, items[0].sellIn, "Expect sellIn after 2 days to be 0")
        XCTAssertEqual(2, items[0].quality, "Expect quality after 2 days to be 2")
        
        XCTAssertEqual(-1, items[1].sellIn, "Expect sellIn after 2 days to be -1")
        XCTAssertEqual(50, items[1].quality, "Expect quality can't be over 50")
        
        app.updateQuality()
        
        XCTAssertEqual(-1, items[0].sellIn, "Expect sellIn after 3 days to be -1")
        XCTAssertEqual(4, items[0].quality, "Expect quality after 3 days to be 4")
        
        XCTAssertEqual(-2, items[1].sellIn, "Expect sellIn after 3 days to be -2")
        XCTAssertEqual(50, items[1].quality, "Expect quality can't be over 50")
    }
    
    func test_backstagePassesItems() {
        
        let items = [
            // Item with normal increase
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 20),
            // Item with double increase
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 20),
            // Item with triple increase
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 20),
            // Item with quality 0 after concert
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 20),
            // Item with maximum quality of 50
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 49),
        ]
        
        let app = GildedRose(items: items)
                
        XCTAssertEqual(15, items[0].sellIn, "Expect sellIn to be initial value of 15")
        XCTAssertEqual(20, items[0].quality, "Expect quality to be initial value of 20")
        
        XCTAssertEqual(11, items[1].sellIn, "Expect sellIn to be initial value of 11")
        XCTAssertEqual(20, items[1].quality, "Expect quality to be initial value of 20")
        
        XCTAssertEqual(6, items[2].sellIn, "Expect sellIn to be initial value of 6")
        XCTAssertEqual(20, items[2].quality, "Expect quality to be initial value of 20")
        
        XCTAssertEqual(1, items[3].sellIn, "Expect sellIn to be initial value of 1")
        XCTAssertEqual(20, items[3].quality, "Expect quality to be initial value of 20")
        
        XCTAssertEqual(15, items[4].sellIn, "Expect sellIn to be initial value of 15")
        XCTAssertEqual(49, items[4].quality, "Expect quality to be initial value of 49")
        
        app.updateQuality()
        
        XCTAssertEqual(14, items[0].sellIn, "Expect sellIn after 1 day to be 14")
        XCTAssertEqual(21, items[0].quality, "Expect quality after 1 day to be 21")
        
        XCTAssertEqual(10, items[1].sellIn, "Expect sellIn after 1 day to be 10")
        XCTAssertEqual(21, items[1].quality, "Expect quality after 1 day to be 21")
        
        XCTAssertEqual(5, items[2].sellIn, "Expect sellIn after 1 day to be 5")
        XCTAssertEqual(22, items[2].quality, "Expect quality after 1 day to be 22")
        
        XCTAssertEqual(0, items[3].sellIn, "Expect sellIn after 1 day to be 0")
        XCTAssertEqual(23, items[3].quality, "Expect quality after 1 day to be 23")
        
        XCTAssertEqual(14, items[4].sellIn, "Expect sellIn after 1 day to be 14")
        XCTAssertEqual(50, items[4].quality, "Expect quality after 1 day to be 50")
    
        app.updateQuality()
        
        XCTAssertEqual(13, items[0].sellIn, "Expect sellIn after 2 days to be 13")
        XCTAssertEqual(22, items[0].quality, "Expect quality after 2 days to be 22")
        
        XCTAssertEqual(9, items[1].sellIn, "Expect sellIn after 2 days to be 9")
        XCTAssertEqual(23, items[1].quality, "Expect quality after 2 days to be 23")
        
        XCTAssertEqual(4, items[2].sellIn, "Expect sellIn after 2 days to be 4")
        XCTAssertEqual(25, items[2].quality, "Expect quality after 2 days to be 25")
        
        XCTAssertEqual(-1, items[3].sellIn, "Expect sellIn after 2 days to be -1")
        XCTAssertEqual(0, items[3].quality, "Expect quality after 2 days to be 0")
        
        XCTAssertEqual(13, items[4].sellIn, "Expect sellIn after 2 days to be 13")
        XCTAssertEqual(50, items[4].quality, "Expect quality after 2 days to be 50")
    }
    
    func test_conjuredItems() {
        
        let items = [
            // Item where quality drops to 0 after sellIn date passed
            Item(name: "Conjured Mana Cake", sellIn: 3, quality: 16),
            // Item where quality drops to 0 before sellIn date passed
            Item(name: "Conjured Mana Cake", sellIn: 3, quality: 4),
        ]
        
        let app = GildedRose(items: items)
                
        XCTAssertEqual(3, items[0].sellIn, "Expect sellIn to be initial value of 3")
        XCTAssertEqual(16, items[0].quality, "Expect quality to be initial value of 16")
        
        XCTAssertEqual(3, items[1].sellIn, "Expect sellIn to be initial value of 3")
        XCTAssertEqual(4, items[1].quality, "Expect quality to be initial value of 4")

        app.updateQuality()
        
        XCTAssertEqual(2, items[0].sellIn, "Expect sellIn after 1 day to be 2")
        XCTAssertEqual(14, items[0].quality, "Expect quality after 1 day to be 14")
        
        XCTAssertEqual(2, items[1].sellIn, "Expect sellIn after 1 day to be 2")
        XCTAssertEqual(2, items[1].quality, "Expect quality can't be less then 2")
        
        app.updateQuality()
        
        XCTAssertEqual(1, items[0].sellIn, "Expect sellIn after 2 days to be 1")
        XCTAssertEqual(12, items[0].quality, "Expect quality after 2 days to be 12")
        
        XCTAssertEqual(1, items[1].sellIn, "Expect sellIn after 2 days to be 1")
        XCTAssertEqual(0, items[1].quality, "Expect quality after 2 days to be 0")
        
        app.updateQuality()
               
        XCTAssertEqual(0, items[0].sellIn, "Expect sellIn after 3 days to be passed sellIn date and be 0")
        XCTAssertEqual(10, items[0].quality, "Expect quality after 3 days to be 10")
        
        XCTAssertEqual(0, items[1].sellIn, "Expect sellIn after 3 days to be passed sellIn date and be 0")
        XCTAssertEqual(0, items[1].quality, "Expect quality can't be less then 0")
        
        app.updateQuality()
               
        XCTAssertEqual(-1, items[0].sellIn, "Expect sellIn after 4 days to be passed sellIn date and be -1")
        XCTAssertEqual(6, items[0].quality, "Expect quality after sellIn date to lower quality twice as fast and be 6")
    }
}
