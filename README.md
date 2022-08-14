<div id="top"></div>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/kaelfdl/sorcerers-lemonade">
    <img src="graphics/logo.png" alt="Logo" width="256" height="32">
  </a>

<h3 align="center">Sorcerer's Lemonade</h3>

  <p align="center">
    A 2D lemonade tycoon game!
    <br />
    <a href="https://github.com/kaelfdl/sorcerers-lemonade"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://kaelfdl.itch.io/sorcerers-lemonade">View Demo</a>
    ·
    <a href="https://github.com/kaelfdl/sorcerers-lemonade/issues">Report Bug</a>
    ·
    <a href="https://github.com/kaelfdl/sorcerers-lemonade/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![Product Name Screen Shot][product-screenshot]

Sorcerer's Lemonade is a 2D lemonade tycoon game inspired by the *Lemonade Tycoon* game developed by Hexacto and Jamdat.

The player takes the role of a lemonade merchant that sells lemonades from a lemonade stand to sorcerers passing by. 

The game progression is set by a simulated day lasting 3 minutes with each minute corresponding to "7:00 am", "12:00 nn", and "3:00 pm". Each day corresponds to a randomly picked set of weather that can be a mixture of 3 *(sunny, rainy, and cloudy)*.

The player has access to the lemonade stand that includes an inventory of lemons and ice blocks that are consumed for each lemonade sold through a *recipe* set up by the player at the beginning of each day.

The player can interact with other merchants such as the *fruit merchant* and the *ice merchant*. These merchants supply the needed ingredients to make the lemonade.

The player gains coins for every lemonade sold. This coin can be used to buy lemons or ice from merchants. 

Ice in the player's inventory melts at the end of each day while lemons spoil every two days. The melting of the ice and spoiling of the lemons deplete the player's inventory of the needed ingredients thereby adding a challenge.

Gaining and losing coins is part of the daily challenge that the player faces. The player can progress through the game indefinitely as long as the player does not go bankrupt.

The game ends when the player does not have lemons in their inventory and can not purchase more lemons.



<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [LÖVE2D][Love2D-url]

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

Check out the game on [itch][itch-url]!

or 

Download the distro code for the game 

### Prerequisites

Be sure to have LÖVE2D installed on your machine, which you can do through the following link:
* LÖVE2D 
    - <https://love2d.org/>

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/kaelfdl/sorcerers-lemonade.git
   ```
2. Then, in a terminal window (located in /Applications/Utilities on Mac or by typing cmd in the Windows task bar), move to the directory where you extracted zelda (recall that the cd command can change your current directory), and run
   ```sh
   cd sorcerers-lemonade
   ```
3. In the current directory, run
   ```sh
   love .
   ```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

A tutorial will be shown to the player when prompted at the start of the game.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Playable version
- [ ] Save and resume feature


See the [open issues](https://github.com/kaelfdl/sorcerers-lemonade/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@Gab_Flordelis](https://twitter.com/Gab_Flordelis) - gabryel.flordelis@gmail.com

Project Link: [https://github.com/kaelfdl/sorcerers-lemonade](https://github.com/kaelfdl/sorcerers-lemonade)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [CS50’s Introduction to Game Development](https://cs50.harvard.edu/games/2018/)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/kaelfdl/sorcerers-lemonade.svg?style=for-the-badge
[contributors-url]: https://github.com/kaelfdl/sorcerers-lemonade/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/kaelfdl/sorcerers-lemonade.svg?style=for-the-badge
[forks-url]: https://github.com/kaelfdl/sorcerers-lemonade/network/members
[stars-shield]: https://img.shields.io/github/stars/kaelfdl/sorcerers-lemonade.svg?style=for-the-badge
[stars-url]: https://github.com/kaelfdl/sorcerers-lemonade/stargazers
[issues-shield]: https://img.shields.io/github/issues/kaelfdl/sorcerers-lemonade.svg?style=for-the-badge
[issues-url]: https://github.com/kaelfdl/sorcerers-lemonade/issues
[license-shield]: https://img.shields.io/github/license/kaelfdl/sorcerers-lemonade.svg?style=for-the-badge
[license-url]: https://github.com/kaelfdl/sorcerers-lemonade/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/gabryelilumin
[product-screenshot]: graphics/sorcerers-lemonade.png
[Love2D-url]: https://love2d.org/
[itch-url]: https://kaelfdl.itch.io/sorcerers-lemonade