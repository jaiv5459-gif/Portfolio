document.addEventListener("DOMContentLoaded", () => {
    
    // --- Sticky Header Logic ---
    const header = document.getElementById("navbar");
    
    window.addEventListener("scroll", () => {
        if (window.scrollY > 50) {
            header.style.top = "10px";
            header.style.maxWidth = "700px";
            // Deepen shadow on scroll
            header.querySelector('.nav-container').style.boxShadow = "0px 10px 30px rgba(0, 0, 0, 0.1)"; 
        } else {
            header.style.top = "24px";
            header.style.maxWidth = "800px";
            header.querySelector('.nav-container').style.boxShadow = "0px 10px 30px rgba(0, 0, 0, 0.03)";
        }
    });

    // --- Scroll Reveal Animation ---
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15 // Triggers when 15% of the item is visible
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                // Stop observing once it's visible so the animation only happens once
                observer.unobserve(entry.target); 
            }
        });
    }, observerOptions);

    // Select all elements with the animation class
    const animatedElements = document.querySelectorAll('.animate-on-scroll');
    animatedElements.forEach(el => observer.observe(el));

    // --- Mobile Menu Toggle Placeholder ---
    const mobileToggle = document.querySelector('.mobile-toggle');
    const navLinks = document.querySelector('.nav-links');

    mobileToggle.addEventListener('click', () => {
        if (navLinks.style.display === 'flex') {
            navLinks.style.display = 'none';
        } else {
            navLinks.style.display = 'flex';
            navLinks.style.flexDirection = 'column';
            navLinks.style.position = 'absolute';
            navLinks.style.top = '70px';
            navLinks.style.left = '0';
            navLinks.style.width = '100%';
            navLinks.style.background = '#FFFFFF';
            navLinks.style.padding = '20px';
            navLinks.style.borderRadius = '16px';
            navLinks.style.boxShadow = '0px 10px 30px rgba(0, 0, 0, 0.1)';
        }
    });
});