import { api, LightningElement, track, wire } from 'lwc';
import getAllContentByChannel from '@salesforce/apex/CMSController.getAllContentByChannel';

export default class SlideShow extends LightningElement {
    @api channelName;
    @track images = [];

    slideIndex = 0;
    autoSlide = true;
    autoplayInterval = 2000;
    autoplayIntervalId;

    @wire(getAllContentByChannel, {channelName: '$channelName'})
    getChanelId({error, data}){
        if(error){
            
        }else{
            console.log(data);
            this.images = data;
        }
    }

    renderedCallback(){
        if(this.autoSlide){
            this.startAutoplay();
        }else{
            this.showSlide(this.slideIndex);
        }
    }

    handlePrev() {
        this.showSlide(this.slideIndex -= 1);
        this.stopAutoplay();
    }
    
    handleNext() {
        this.showSlide(this.slideIndex += 1);
        this.stopAutoplay();
    }

    showSlide(n) {
        let slides = this.template.querySelectorAll(".slide");
        if(slides != null && slides != undefined){
            if (this.slideIndex >= slides.length) {
                this.slideIndex = 0;
            }
            if (this.slideIndex < 0) {
                this.slideIndex = slides.length-1;
            }
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = 'none';
            }
            if(slides.length >= 1){
                slides[this.slideIndex].style.display = 'block';
            }
        }
    }
      
    startAutoplay() {
        this.showSlide(this.slideIndex);
        const that = this;
        if(this.autoplayIntervalId == null){
            this.autoplayIntervalId = setInterval(() => {
                that.showSlide(that.slideIndex += 1);
            }, this.autoplayInterval);
        }
    }
    
    stopAutoplay() {
        if(this.autoplayIntervalId != null){
            clearInterval(this.autoplayIntervalId);
            this.autoplayIntervalId = null;
            if(this.autoSlide){
                this.startAutoplay();
            }
        }
    }
}